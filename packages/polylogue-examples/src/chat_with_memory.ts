import { config as loadDotenvConfig } from 'dotenv'
loadDotenvConfig()

import { setConfig as setOpenAiConfig } from 'polylogue-base/build/api/openai'

import OpenAiChat from 'polylogue-base/build/agent/chat/OpenAI'
import VerbatimMemory from 'polylogue-base/build/agent/chat/memory/Verbatim'
import ChatWithMemory from 'polylogue-base/build/agent/chat/WithMemory'

export default async function main() {
  setOpenAiConfig({
    openai_api_key: process.env.openai_api_key,
  })

  const agent = new ChatWithMemory(
    new OpenAiChat({
      model: 'gpt-3.5-turbo',
      systemPrompt: "You are a helpful arithmetic calculator. You reply with ONLY the simplified result of the user's question."
    }),
    new VerbatimMemory()
  )

  await agent.chat("What is 1 + 2?")
  await agent.chat("What is 1 + 3?")
  await agent.chat("What is 2 + 4?")

  const history = await agent.memoryAgent.getMemoryArray()
  console.log("history:", history)
}
