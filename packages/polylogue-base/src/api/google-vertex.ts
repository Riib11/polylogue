import { OAuth2Client } from 'google-auth-library'

// =============================================================================
// chat completions
// =============================================================================

export type ChatApiEndpoint = 'us-central1-aiplatform.googleapis.com'

export type ChatModelId = 'chat-bison@001' | 'codechat-bison@001'

export type ChatInput = ChatInputRequired & ChatInputOptional

export type ChatInputRequired = {
  api_endpoint: ChatApiEndpoint,
  project_id: string,
  model_id: ChatModelId
  messages: ChatMessage[],
  parameters: ChatInputParameters
}

export type ChatInputOptional = {
  context?: string,
  examples?: ChatExample[],
}

export type ChatInputParameters = {
  temperature?: number,
  maxOutputTokens?: number,
  topP?: number,
  topK?: number
}

export type ChatExample = {
  input: ChatMessage,
  output: ChatMessage
}

export type ChatAuthor = 'user' | 'bot' | '0' | '1'

export type ChatMessage = {
  author: ChatAuthor
  content: string,
  citationMetadata?: ChatCitationMetadata
}

export type ChatCitationMetadata = {
  citations: ChatCitation[]
}

export type ChatCitation = string // TODO: what is this?

export type ChatOutput = {
  predictions: ChatPrediction[]
}

export type ChatPrediction = {
  candidates: ChatMessage[],
  citationMetadata?: ChatCitationMetadata,
  safetyAttributes?: ChatSafetyAttributes
}

export type ChatSafetyAttributes = {
  scores: [],
  categories: [],
  blocked: false
}

export async function chat(client: OAuth2Client, input: ChatInput): Promise<ChatOutput> {
  const result = await client.request({
    method: 'POST',
    url: `https://${input.api_endpoint}/v1/projects/${input.project_id}/locations/us-central1/publishers/google/models/${input.model_id}:predict`,
    data: {
      instances: [
        {
          context: input.context,
          examples: input.examples,
          messages: input.messages,
        }
      ],
      parameters: input.parameters
    }
  })
  return result.data as ChatOutput
}