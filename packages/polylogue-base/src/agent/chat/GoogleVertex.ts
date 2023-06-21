import { EmptyResultsError } from "../../api/error";
import { ChatApiEndpoint, ChatInputOptional, ChatInputParameters, ChatMessage, ChatModelId, chat } from "../../api/google-vertex";
import Chat from "../Chat";
import { OAuth2Client } from 'google-auth-library'

export default class extends Chat<ChatMessage> {
  readonly client: OAuth2Client
  readonly api_endpoint: ChatApiEndpoint
  readonly project_id: string
  model_id: ChatModelId
  chatCompletionInputOptional: ChatInputOptional
  parameters: ChatInputParameters

  constructor(
    client: OAuth2Client,
    api_endpoint: ChatApiEndpoint,
    project_id: string,
    model_id: ChatModelId
  ) {
    super()
    this.client = client
    this.api_endpoint = api_endpoint
    this.project_id = project_id
    this.model_id = model_id
  }

  async chat(history: ChatMessage[]): Promise<ChatMessage> {
    const result = await chat(this.client, {
      api_endpoint: this.api_endpoint,
      project_id: this.project_id,
      model_id: this.model_id,
      messages: history,
      parameters: this.parameters
    })
    if (result.predictions.length < 1) throw new EmptyResultsError(history)
    if (result.predictions[0].candidates.length < 1) throw new EmptyResultsError(history)
    return result.predictions[0].candidates[0]
  }
}