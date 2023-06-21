import Chat from "../Chat";
import * as readline from 'readline'

export default class extends Chat<string> {
  prompt: string

  constructor(prompt: string) {
    super()
    this.prompt = prompt
  }

  async chat(history: string[]): Promise<string> {
    const cli = readline.createInterface({
      input: process.stdin,
      output: process.stdout
    })

    const prompt = `${history.join('\n')}\n${this.prompt}`
    try {
      const result: string = await new Promise(resolve => cli.question(prompt, answer => resolve(answer)))
      return result
    } finally {
      cli.close()
    }
  }
}