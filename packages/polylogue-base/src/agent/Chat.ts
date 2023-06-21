import Agent from "../Agent"
import { ChatMessage } from "../api/universal"

export default abstract class extends Agent {
  abstract chatArray(messages: ChatMessage[]): Promise<ChatMessage>

  async chat(content: string): Promise<ChatMessage> {
    return this.chatArray([{ type: 'client', content }])
  }
}

export class EmptyNewMessagesError extends Error {
  constructor() {
    super("Expected a non-empty array of new messages.")
  }
}
