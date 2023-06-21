import { ChatMessage } from "../../api/universal";
import Chat from "../Chat";
import * as readline from 'readline'

export default class extends Chat {
  prompt: string

  constructor(prompt: string) {
    super()
    this.prompt = prompt
  }

  async chatArray(messages: ChatMessage[]): Promise<ChatMessage> {
    const cli = readline.createInterface({
      input: process.stdin,
      output: process.stdout
    })

    const prompt = `${messages.map(msg => `[${msg.type}] ${msg.content}`).join('\n')}\n${this.prompt}`
    try {
      const result: string = await new Promise(resolve => cli.question(prompt, answer => resolve(answer)))
      return ({ type: 'client', content: result })
  } finally {
    cli.close()
  }
  }
}