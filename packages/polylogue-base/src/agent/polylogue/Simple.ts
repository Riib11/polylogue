import Polylogue, { Interlocutors } from "../Polylogue";

export default class <name extends string, message> extends Polylogue<name, message>{
  _transition: (source: name, messages: message[]) => Promise<{ target: name, messages: message[] } | undefined>

  constructor(interlocutors: Interlocutors<name, message>, _transition: (source: name, messages: message[]) => Promise<{ target: name, messages: message[] } | undefined>) {
    super(interlocutors)
    this._transition = _transition
  }

  transition(source: name, messages: message[]): Promise<{ target: name, messages: message[] } | undefined> {
    return this._transition(source, messages)
  }
}