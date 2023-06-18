import Agent from "../Agent";
import Chat from "./Chat";

export type Interlocutors<name extends string, message> = { [n in name]: Chat<message> }

export default abstract class <name extends string, message> extends Agent {
  interlocutors: Interlocutors<name, message>

  constructor(interlocutors: Interlocutors<name, message>) {
    super()
    this.interlocutors = interlocutors
  }

  abstract transition(source: name, messages: message[]): Promise<{ target: name, messages: message[] } | undefined>

  async chatTo(name: name, inputMessages: message[]) {
    const outputMessage = await this.interlocutors[name].chat(inputMessages)
    const trans = await this.transition(name, [outputMessage])
    if (trans === undefined) return
    await this.chatTo(trans.target, trans.messages)
  }
}