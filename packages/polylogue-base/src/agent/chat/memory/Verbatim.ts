import { ChatMessage } from "../../../api/universal";
import Memory from "../Memory";

export default class extends Memory{
  messages: ChatMessage[] = []

  async insert(message: ChatMessage): Promise<void> {
    this.messages.push(message)
  }

  async getMemoryArray(): Promise<ChatMessage[]> {
    return this.messages
  }
}
