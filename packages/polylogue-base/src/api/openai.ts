import axios from 'axios'

// =============================================================================
// chat completions
// =============================================================================

export type ChatModel = 'gpt-4' | 'gpt-4-0613' | 'gpt-4-32k' | 'gpt-4-32k-0613' | 'gpt-3.5-turbo' | 'gpt-3.5-turbo-0613' | 'gpt-3.5-turbo-16k' | 'gpt-3.5-turbo-16k-0613'

export type ChatMessage = { role: ChatRole, content: string }

export type ChatRole = 'assistant' | 'user' | 'system'

export type ChatCallFunction
  = 'none' // won't call function
  | 'auto' // can call any function or not
  | { 'name': string } // must call function with name

export type ChatCompletionInput = ChatCompletionInputRequired & ChatCompletionInputOptional

export type ChatCompletionInputRequired = {
  model: ChatModel,
  messages: ChatMessage[],
}

export type ChatCompletionInputOptional = {
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

export type ChatCompletionOutput = {
  id: string,
  object: 'text_completion',
  created: number,
  choices: ChatCompletionChoice[],
  usage: ChatCompletionUsage,
}

export type ChatCompletionChoice = {
  index: number,
  message: ChatMessage
}

export type ChatCompletionUsage = {
  prompt_tokens: number,
  completion_tokens: number,
  total_tokens: number,
}

// TODO: handle http errors
export async function chat(openai_api_key: string, input: ChatCompletionInput): Promise<ChatCompletionOutput> {
  const result = await axios.post('https://api.openai.com/v1/chat/completions',
    input,
    {
      'headers': {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + openai_api_key
      }
    }
  )
  return result.data as ChatCompletionOutput
}
