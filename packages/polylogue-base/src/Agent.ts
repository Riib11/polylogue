import * as uuid from 'uuid'

export const agents = new Map<string, Agent>();

export default class Agent {
  // uuid
  readonly _uuid: string = uuid.v4()
  readonly uuid = () => this._uuid

  constructor() {
    agents.set(this._uuid, this)
  }
}
