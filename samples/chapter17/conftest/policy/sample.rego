package main

deny[msg] {
  input.kind == "Deployment"
  not (input.spec.selector.matchLabels.app == input.spec.template.metadata.labels.app)
  msg = sprintf("Pod Template と Selector には同じ app ラベルを付与してください: %s", [input.metadata.name])
}

