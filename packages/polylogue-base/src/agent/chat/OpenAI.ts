import { ChatCompletionInputOptional, ChatMessage, ChatModel, chatCompletion } from "../../api/openai";
import Chat, { EmptyHistoryError } from "../Chat";

export default class extends Chat<ChatMessage> {
  readonly openai_api_key: string
  readonly model: ChatModel
  readonly chatCompletionInputOptional: ChatCompletionInputOptional

  constructor(
    openai_api_key: string,
    model: ChatModel = 'gpt-3.5-turbo',
    chatCompletionInputOptional: ChatCompletionInputOptional = {}
  ) {
    super()
    this.openai_api_key = openai_api_key
    this.model = model
    this.chatCompletionInputOptional = chatCompletionInputOptional
  }

  async chat(history: ChatMessage[]): Promise<ChatMessage> {
    if (history.length === 0) throw new EmptyHistoryError()
    const result = await chatCompletion(this.openai_api_key,
      {
        messages: history,
        model: this.model,
        ...this.chatCompletionInputOptional,
      }
    )
    if (result.choices.length < 1) throw new EmptyChoicesInChatCompletionError()
    return result.choices[0].message
  }
}

export class EmptyChoicesInChatCompletionError extends Error {
  constructor() {
    super("Expected at least one choice.")
  }
}
