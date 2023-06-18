import Memory from "../Memory";

export default class <message> extends Memory<message>{
  messages: message[] = []

  async insert(message: message): Promise<void> {
    this.messages.push(message)
  }

  async getMemoryArray(): Promise<message[]> {
    return this.messages
  }
}
