import Agent from "../../Agent"
import { ChatMessage } from "../../api/universal";

export default abstract class extends Agent {
  abstract insert(message: ChatMessage): Promise<void>
  abstract getMemoryArray(): Promise<ChatMessage[]>
}

