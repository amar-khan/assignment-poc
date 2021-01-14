#!/bin/bash

# ECS config
{
  echo "ECS_CLUSTER=test-poc-cluster"
} >> /etc/ecs/ecs.config

start ecs

echo "Done"