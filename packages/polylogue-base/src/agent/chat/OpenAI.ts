import { EmptyChoicesInResponse as EmptyResults } from "../../api/error";
import { ChatCompletionInputOptional, ChatMessage, ChatModel, chat } from "../../api/openai";
import Chat, { EmptyHistoryError } from "../Chat";

export default class extends Chat<ChatMessage> {
  readonly openai_api_key: string
  model: ChatModel
  chatCompletionInputOptional: ChatCompletionInputOptional

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
    const result = await chat(this.openai_api_key,
      {
        messages: history,
        model: this.model,
        ...this.chatCompletionInputOptional,
      }
    )
    if (result.choices.length < 1) throw new EmptyResults()
    return result.choices[0].message
  }
}

