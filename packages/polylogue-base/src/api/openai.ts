import axios from 'axios'

type Config = {
  openai_api_key?: string
}
const config: Config = {}

export function setConfig<config extends Config>(c: config): void {
  Object.assign(config, c)
}

// =============================================================================
// chat completion
//
// source: https://platform.openai.com/docs/guides/gpt/chat-completions-api
// =============================================================================

export type ChatModel = 'gpt-4' | 'gpt-4-0613' | 'gpt-4-32k' | 'gpt-4-32k-0613' | 'gpt-3.5-turbo' | 'gpt-3.5-turbo-0613' | 'gpt-3.5-turbo-16k' | 'gpt-3.5-turbo-16k-0613'

export type ChatMessage = { role: ChatRole, content: string }

export type ChatRole = 'assistant' | 'user' | 'system'

export const user = (content: string): ChatMessage => ({ role: 'user', content })
export const assistant = (content: string): ChatMessage => ({ role: 'assistant', content })
export const system = (content: string): ChatMessage => ({ role: 'system', content })

export type ChatCallFunction
  = 'none' // won't call function
  | 'auto' // can call any function or not
  | { 'name': string } // must call function with name

export type ChatInput = ChatInputRequired & ChatInputOptional

export type ChatInputRequired = {
  model: ChatModel,
  messages: ChatMessage[],
}

export type ChatInputOptional = {
  function_call?: ChatCallFunction,
  temperature?: number,
  top_p?: string,
  n?: number,
  stream?: boolean,
  stop?: string | string[],
  max_tokens?: number,
  presence_penalty?: number,
  frequesncy_penalty?: number,
  logit_bias?: { [key: string]: number },
  user?: string
}

export type ChatOutput = {
  id: string,
  object: 'text_completion',
  created: number,
  choices: ChatChoice[],
  usage: ChatUsage,
}

export type ChatChoice = {
  message: ChatMessage,
  index: number,
  finish_reason: ChatFinishReason,
}

export type ChatFinishReason = 'stop' | 'length' | 'function_call' | 'content_filter' | null

export type ChatUsage = {
  prompt_tokens: number,
  completion_tokens: number,
  total_tokens: number,
}

// TODO: handle http errors
export async function chat(input: ChatInput, openai_api_key?: string): Promise<ChatOutput> {
  const result = await axios.post('https://api.openai.com/v1/chat/completions',
    input,
    {
      'headers': {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + (openai_api_key ?? config.openai_api_key)
      }
    }
  )
  return result.data as ChatOutput
}
