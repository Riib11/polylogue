import { EmptyResultsError } from "../../api/error";
import { ChatInputOptional, ChatMessage, ChatModel, chat } from "../../api/openai";
import Chat, { EmptyHistoryError } from "../Chat";

export type Config = {
  model: ChatModel,
  systemMessage?: ChatMessage,
  chatCompletionInputOptional?: ChatInputOptional
  openai_api_key?: string,
}

export default class extends Chat<ChatMessage> {
  readonly config: Config
  constructor(config: Config) {
    super()
    this.config = config
  }

  async chat(messages: ChatMessage[]): Promise<ChatMessage> {
    messages = (this.config.systemMessage ? [this.config.systemMessage] : []).concat(messages)
    if (messages.length === 0) throw new EmptyHistoryError()
    const result = await chat(
      {
        model: this.config.model,
        messages,
        ...this.config.chatCompletionInputOptional,
      },
      this.config.openai_api_key,
    )
    if (result.choices.length < 1) throw new EmptyResultsError(messages)
    return result.choices[0].message
  }
}

