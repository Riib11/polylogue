import { v4 as makeUUID } from 'uuid';

const agents = new Map()
const agentStates = new Map()

export const newAgent = agent => state => {
  let uuid = makeUUID()
  agents.set(uuid, agent)
  agentStates.set(uuid, state)
  return uuid
};

export const getAgent = id => {
  return agents.get(id)
}

export const getAgentState = id => {
  return agentStates.get(id)
}

export const setAgentState = id => state => {
  agentStates.set(id, state)
}
