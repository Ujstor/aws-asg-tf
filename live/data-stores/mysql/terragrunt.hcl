terrafrom {
  source = "github.com/ujstor/aws-terraform//modules/modules/data-stores/mysql?ref=v0.1.3"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  db_name = "example_live"
}
