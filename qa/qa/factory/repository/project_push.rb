module QA
  module Factory
    module Repository
      class ProjectPush < Factory::Repository::Push
        attribute :project do
          Factory::Resource::Project.fabricate! do |resource|
            resource.name = 'project-with-code'
            resource.description = 'Project with repository'
          end
        end

        def initialize
          @file_name = 'file.txt'
          @file_content = '# This is test project'
          @commit_message = "This is a test commit"
          @branch_name = 'master'
          @new_branch = true
        end

        def repository_http_uri
          @repository_http_uri ||= begin
            project.visit!
            Page::Project::Show.act do
              choose_repository_clone_http
              repository_location.uri
            end
          end
        end

        def repository_ssh_uri
          @repository_ssh_uri ||= begin
            project.visit!
            Page::Project::Show.act do
              choose_repository_clone_ssh
              repository_location.uri
            end
          end
        end
      end
    end
  end
end
