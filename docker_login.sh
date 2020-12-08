#!/usr/bin/env bash

if [ "$LAB" = "CAD" ]; then
  echo "Login into zjulearning docker server"
  docker login cad-data.zjulearning.org:5000 -u zjulearning -p zjulearning
elif [ "$LAB" = "FABU" ]; then
  docker login docker.fabu.ai:5000 -u fabu -p fabu
  echo "Login into fabu docker server"
else
  echo "Unknown lab: $LAB"
fi
