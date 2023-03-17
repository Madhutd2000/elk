output "Elastic_search" {
  value =join("\n", aws_instance.ES.*.private_ip)
}
output "Logstash" {
  value = join("\n", aws_instance.LS.*.private_ip)
}
output "Kibana" {
  value = join("\n", aws_instance.KI.*.private_ip)
}

resource "local_file" "hosts_cfg" {

depends_on = [
   aws_instance.ES,
   aws_instance.LS,
   aws_instance.KI
]
  content = templatefile("hosts.tpl",
    {
      es  = aws_instance.ES.*.private_ip
      ls  = aws_instance.LS.*.private_ip
      ki  = aws_instance.KI.*.private_ip
      usr = var.user
      pemkey = var.PemkeyName
    }
  )
  
   filename = "../ansible_script/hosts.ini"
}
