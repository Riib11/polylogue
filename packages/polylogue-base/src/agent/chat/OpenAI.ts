import { EmptyResultsError } from "../../api/error";
import { ChatMessage, openAiChatMessageTranslation as translation } from "../../api/universal";
import * as OpenAi from '../../api/openai'
import Chat, { EmptyNewMessagesError } from "../Chat";

export type Config = {
  model: OpenAi.ChatModel,
  systemPrompt?: string,
  chatCompletionInputOptional?: OpenAi.ChatInputOptional
  openai_api_key?: string,
}

export default class extends Chat {
  readonly config: Config
  constructor(config: Config) {
    super()
    this.config = config
  }

  async chatArray(messages: ChatMessage[]): Promise<ChatMessage> {
    const openaiMessages: OpenAi.ChatMessage[] =
      (this.config.systemPrompt ?
        [OpenAi.system(this.config.systemPrompt)] :
        [])
        .concat(messages.map(msg => translation.to(msg)))
    if (messages.length === 0) throw new EmptyNewMessagesError()
    const result = await OpenAi.chat(
      {
        model: this.config.model,
        // messages: messages.map(msg => translation.to(msg)),
        messages: openaiMessages,
        ...this.config.chatCompletionInputOptional,
      },
      this.config.openai_api_key,
    )
    if (result.choices.length < 1) throw new EmptyResultsError(messages)
    return translation.from(result.choices[0].message)
  }
}

