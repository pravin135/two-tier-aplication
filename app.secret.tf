resource "kubernetes_secret" "webapp" {
  metadata {
    name      = "webapp"
    namespace = "k8s-workshop"
  }

  data = {
    val1 = "it_is_a_secret_to_everybody"

    val2 = "enemies=aliens\nlives=3\nenemies.cheat=true\nenemies.cheat.level=noGoodRotten\nsecret.code.passphrase=UUDDLRLRBABAS\nsecret.code.allowed=true\nsecret.code.lives=30\n\n"
  }

  type = "Opaque"
}