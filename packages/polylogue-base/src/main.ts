/*
import { chatCompletion } from "./api/openai"
import { config } from 'dotenv'
config()

async function main() {
  const result = await chatCompletion(process.env.openai_api_key, {
    'model': 'gpt-3.5-turbo',
    'messages': [
      { 'role': 'user', 'content': 'Hello, world!' }
    ]
  })
  console.log(result.choices.map(choice => choice.message.content))
}

main()
*/

import { Interlocutors } from "./agent/Polylogue";
import Echo from "./agent/chat/Echo";
import Polylogue from "./agent/polylogue/Simple"
import ChatOpenAI from "./agent/chat/OpenAI"
import Translator from "./agent/chat/Translator";
import { ChatMessage } from "./api/openai";
import { config } from 'dotenv'
config()

type Name = 'chat1' | 'chat2'

const otherName = (name: Name): Name => {
  switch (name) {
    case 'chat1': return 'chat2'
    case 'chat2': return 'chat1'
  }
}

type Message = { source: Name, content: string }

// const chat1 = new Echo()
// const chat2 = new Echo()

const chat1 = new Translator<ChatMessage, Message>(
  new ChatOpenAI(process.env.openai_api_key),
  (msg: Message) => {
    switch (msg.source) {
      case 'chat1': return { role: 'user', content: msg.content }
      case 'chat2': return { role: 'assistant', content: msg.content }
    }
  },
  (msg: ChatMessage) => {
    switch (msg.role) {
      case 'user': return { source: 'chat2', content: msg.content }
      case 'assistant': return { source: 'chat1', content: msg.content }
      case 'system': throw new Error("chat should not reply with system message")
    }
  }
)
const chat2 = new Translator<ChatMessage, Message>(
  new ChatOpenAI(process.env.openai_api_key),
  (msg: Message) => {
    switch (msg.source) {
      case 'chat2': return { role: 'user', content: msg.content }
      case 'chat1': return { role: 'assistant', content: msg.content }
    }
  },
  (msg: ChatMessage) => {
    switch (msg.role) {
      case 'user': return { source: 'chat1', content: msg.content }
      case 'assistant': return { source: 'chat2', content: msg.content }
      case 'system': throw new Error("chat should not reply with system message")
    }
  }
)

const history: Message[] = [
  {
    source: 'chat1',
    content: 'Hello, world!'
  }
]

const polylogue = new Polylogue<Name, Message>(
  { chat1, chat2 } as Interlocutors<Name, Message>,
  async (source, messages) => {
    messages.forEach(message => {
      console.log(`[${source}] ${message.content}`)
      history.push({ source, content: message.content })
    })
    if (history.length > 3) return
    return { target: otherName(source), messages: history }
  }
)

polylogue.chatTo('chat2', history)
