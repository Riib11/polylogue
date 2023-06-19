import { Interlocutors } from 'polylogue-base/build/agent/Polylogue'
import Echo from 'polylogue-base/build/agent/chat/Echo'
import Polylogue from 'polylogue-base/build/agent/polylogue/Simple'
import ChatGoogleVertex from 'polylogue-base/build/agent/chat/GoogleVertex'
import Translator from 'polylogue-base/build/agent/chat/Translator'
import { ChatAuthor, ChatMessage } from 'polylogue-base/build/api/google-vertex'
import CommandLine from 'polylogue-base/build/agent/chat/CommandLine'
import { GoogleAuth, OAuth2Client } from 'google-auth-library'
import { config } from 'dotenv'
config()

type Name = 'chat1' | 'chat2'

const otherName = (name: Name): Name => {
  switch (name) {
    case 'chat1': return 'chat2'
    case 'chat2': return 'chat1'
  }
}

const nameAuthorMap: { [name in Name]: Map<Name, ChatAuthor> } = {
  'chat1': new Map([
    ['chat1', '0'],
    ['chat2', '1']
  ]),
  'chat2': new Map([
    ['chat1', '1'],
    ['chat2', '0']
  ])
}

function fromNameToAuthor(you: Name, name: Name): ChatAuthor {
  const m = nameAuthorMap[you]
  return m.get(name)
}

function fromAuthorToName(you: Name, author: ChatAuthor): Name {
  const m = nameAuthorMap[you]
  for (const [name, a] of m) if (a === author) return name
  throw new Error(`author ${author} not found in nameAuthorMap`)
}

function toChatMessage(you: Name, msg: Message): ChatMessage {
  return { author: fromNameToAuthor(you, msg.source), content: msg.content }
}

function fromChatMessage(you: Name, msg: ChatMessage): Message {
  return { source: fromAuthorToName(you, msg.author), content: msg.content }
}

type Message = { source: Name, content: string }

async function main() {
  const auth = new GoogleAuth({
    credentials: {
      client_email: process.env.gcloud_auth_client_email,
      private_key: process.env.gcloud_auth_private_key,
    },
    projectId: process.env.gcloud_auth_projectId,
    scopes: "https://www.googleapis.com/auth/cloud-platform"
  })
  const client = await auth.getClient() as OAuth2Client

  // const chat1 = new Translator<ChatMessage, Message>(
  //   new ChatGoogleVertex(
  //     client,
  //     'us-central1-aiplatform.googleapis.com',
  //     'cardcrafters',
  //     'chat-bison@001'
  //   ),
  //   (msg: Message) => toChatMessage('chat1', msg),
  //   (msg: ChatMessage) => fromChatMessage('chat1', msg)
  // )

  const chat1 = new Translator<string, Message>(
    new CommandLine("[user] "),
    (msg) => {
      switch (msg.source) {
        case 'chat1': return `[user] ${msg.content}`
        case 'chat2': return `[bot] ${msg.content}`
      }
    },
    msg => ({ source: 'chat1', 'content': msg })
  )

  const chat2 = new Translator<ChatMessage, Message>(
    new ChatGoogleVertex(
      client,
      'us-central1-aiplatform.googleapis.com',
      'cardcrafters',
      'chat-bison@001'
    ),
    (msg: Message) => toChatMessage('chat2', msg),
    (msg: ChatMessage) => fromChatMessage('chat2', msg)
  )

  // const history: Message[] = [
  //   {
  //     source: 'chat1',
  //     content: 'Hello, world!'
  //   }
  // ]
  const history: Message[] = []

  const polylogue = new Polylogue<Name, Message>(
    { chat1, chat2 } as Interlocutors<Name, Message>,
    async (source, messages) => {
      // if (source === 'chat1') console.log("======================================================")
      messages.forEach(message => {
        history.push({ source, content: message.content })
      })
      // if (history.length > 3) return
      switch (source) {
        case 'chat1': return { target: otherName(source), messages: messages }
        case 'chat2': return { target: otherName(source), messages: history }
      }
    }
  )

  polylogue.chatTo('chat1', history)
}

main()

/*
import * as readline from 'readline';

async function main() {
  const cli = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  })

  await cli.question("Enter some text: ", input => {
    console.log(`input: ${input}`)
    cli.close()
  })
}

main()
*/

/*
import * as openai from "./api/openai"
import * as vertex from "./api/google-vertex"
import { GoogleAuth, OAuth2Client } from "google-auth-library"
import { config } from 'dotenv'
config()

async function main() {
  const result = await chat(process.env.openai_api_key, {
    'model': 'gpt-3.5-turbo',
    'messages': [
      { 'role': 'user', 'content': 'Hello, world!' }
    ]
  })
  console.log(result.choices.map(choice => choice.message.content))
}

main()
*/

/*
async function main() {
  const auth = new GoogleAuth({
    credentials: {
      client_email: process.env.gcloud_auth_client_email,
      private_key: process.env.gcloud_auth_private_key,
    },
    projectId: process.env.gcloud_auth_projectId,
    scopes: "https://www.googleapis.com/auth/cloud-platform"
  })
  const client = await auth.getClient() as OAuth2Client

  const result = await vertex.chat({
    client,
    api_endpoint: 'us-central1-aiplatform.googleapis.com',
    project_id: 'cardcrafters',
    model_id: 'chat-bison@001',
    messages: [
      { author: 'user', content: 'Hello world!' }
    ],
    parameters: {
      temperature: 0.6,
      maxOutputTokens: 100,
      topP: 1,
      topK: 0
    }
  })

  const msg = result.predictions[0].candidates[0]
  console.log(`[${msg.author}] ${msg.content}`)
}

main()
*/


/*
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
*/