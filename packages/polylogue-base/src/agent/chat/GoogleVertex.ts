import { EmptyResultsError } from "../../api/error";
import * as GoogleVertex from '../../api/google-vertex'
import { ChatMessage, googleVertexChatMessageTranslation as translation } from "../../api/universal";
import Chat from "../Chat";
import { OAuth2Client } from 'google-auth-library'

export default class extends Chat {
  readonly client: OAuth2Client
  readonly api_endpoint: GoogleVertex.ChatApiEndpoint
  readonly project_id: string
  model_id: GoogleVertex.ChatModelId
  chatCompletionInputOptional: GoogleVertex.ChatInputOptional
  parameters: GoogleVertex.ChatInputParameters

  constructor(
    client: OAuth2Client,
    api_endpoint: GoogleVertex.ChatApiEndpoint,
    project_id: string,
    model_id: GoogleVertex.ChatModelId
  ) {
    super()
    this.client = client
    this.api_endpoint = api_endpoint
    this.project_id = project_id
    this.model_id = model_id
  }

  async chatArray(messages: ChatMessage[]): Promise<ChatMessage> {
    const result = await GoogleVertex.chat(this.client, {
      api_endpoint: this.api_endpoint,
      project_id: this.project_id,
      model_id: this.model_id,
      messages: messages.map(msg => translation.to(msg)),
      parameters: this.parameters
    })
    if (result.predictions.length < 1) throw new EmptyResultsError(messages)
    if (result.predictions[0].candidates.length < 1) throw new EmptyResultsError(messages)
    return translation.from(result.predictions[0].candidates[0])
  }
}