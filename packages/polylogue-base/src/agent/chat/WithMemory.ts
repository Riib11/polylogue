import { ChatMessage } from '../../api/universal'
import Chat from '../Chat'
import Memory from './Memory'

export default class extends Chat {
  readonly chatAgent: Chat
  readonly memoryAgent: Memory

  constructor(
    chatAgent: Chat,
    memoryAgent: Memory
  ) {
    super()
    this.chatAgent = chatAgent
    this.memoryAgent = memoryAgent
  }

  async chatArray(messages: ChatMessage[]): Promise<ChatMessage> {
    // console.log("==========================================")
    // insert new message into memory
    messages.forEach(message => this.memoryAgent.insert(message))
    // get history from memory
    const history = await this.memoryAgent.getMemoryArray()
    // console.log("WithMemory.chatArray.history", history)
    // chat using history
    const reply = await this.chatAgent.chatArray(history)
    // insert reply into history
    this.memoryAgent.insert(reply)
    return reply
  }
}