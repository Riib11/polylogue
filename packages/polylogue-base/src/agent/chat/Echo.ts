import { ChatMessage } from "../../api/universal";
import Chat, { EmptyNewMessagesError } from "../Chat";

export default class extends Chat {
  async chatArray(messages: ChatMessage[]): Promise<ChatMessage> {
    if (messages.length === 0) throw new EmptyNewMessagesError()
    return messages[messages.length - 1]
  }
}
