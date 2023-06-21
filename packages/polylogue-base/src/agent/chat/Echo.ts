import Chat, { EmptyHistoryError } from "../Chat";

export default class <message> extends Chat<message> {
  async chat(messages: message[]): Promise<message> {
    if (messages.length === 0) throw new EmptyHistoryError()
    return messages[messages.length - 1]
  }
}
