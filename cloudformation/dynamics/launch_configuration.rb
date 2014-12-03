# Dynamic: launch_configuration
# Description: Creates an AWS::AutoScaling::LaunchConfiguration
# resource
# _config Inputs:
#   :image_id as string
#   :instance_type as string
#   :key_name as string
#   :security_groups as array of ref!s
#
# Outputs:
#   #{_name}_launch_configuration as string
#   image_id as string
#   instnace_type as string
#   key_name as string
#   security_groups as array of ref!s

SparkleFormation.dynamic(:launch_configuration) do |_name, _config={}|

  lc_name = "#{_name}_launch_configuration".to_sym

  resources(lc_name) do
    type 'AWS::AutoScaling::LaunchConfiguration'
    registry!(:apt_get_update, "#{_name}_launch_configuration")
    properties do
      image_id _config[:image_id]
      instance_type _config[:instance_type]
      key_name _config[:key_name]
      security_groups _config[:security_groups] || []
    end
  end

  outputs(lc_name) do
    description "The name of the created #{ ref!(lc_name) } LaunchConfiguration resource"
    value "#{_name}_launch_configuration"
  end

  outputs("#{_name}_image_id".to_sym) do
    description "The image ID for the #{ ref!(lc_name) } LaunchConfiguration resource"
    value _config[:image_id]
  end

  outputs("#{_name}_instance_type".to_sym) do
    description "The instance type for the #{ ref!(lc_name) } LaunchConfiguration resource"
    value _config[:instance_type]
  end

  outputs("#{_name}_key_name".to_sym) do
    description 'The key pair name for the #{ ref!(lc_name) } LaunchConfiguration resource'
    value _config[:key_name]
  end

  outputs("#{_name}_security_groups".to_sym) do
    description "The list of security groups for the #{ ref!(lc_name) } LaunchConfiguration resource"
    value _config[:security_groups].join(',')
  end

end