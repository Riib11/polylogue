import Chat, { EmptyHistoryError } from "../Chat";

export default class <message> extends Chat<message> {
  async chat(history: message[]): Promise<message> {
    if (history.length === 0) throw new EmptyHistoryError()
    return history[history.length - 1]
  }
}
