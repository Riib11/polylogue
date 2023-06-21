/*
import { config as loadDotenvConfig }  from 'dotenv'
loadDotenvConfig()

import { setConfig as setOpenAiConfig } from 'polylogue-base/build/api/openai'
import PredictOpenAI from 'polylogue-base/build/agent/predict/OpenAI'

export default async function main() {
  setOpenAiConfig({
    openai_api_key: process.env.openai_api_key,
  })

  const oracle = new PredictOpenAI({
    model: 'gpt-3.5-turbo',
  })

  const reply = await oracle.predict('Hello, world!')
  console.log(reply)
}
*/