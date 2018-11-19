#require "google/apis/jobs_v3"

#GoogleAPI = Google::Apis::JobsV3
#JobsAPI = GoogleAPI::CloudTalentSolutionService.new
#JobsAPI.authorization = Google::Auth.get_application_default(
#  "https://www.googleapis.com/auth/jobs"
#)
#project_id = "skillmatic-218900"
#parent = "projects/#{project_id}"
#
#apirequest = {
#    fields: {
#        searchMode: "JOB_SEARCH",
#        jobView: "JOB_VIEW_FULL",
#        jobQuery: {
#            query: "Ruby on Rails Developer",
#            jobCategories: [ "COMPUTER_AND_IT" ],
#            employmentTypes: [ "FULL_TIME" ],
#            languageCodes: [ "en" ]
#        },
#        requestMetadata: {
#          domain: "console.aws.amazon.com",
#          sessionId: "1",
#          userId: "2"
#        }
#    }
#}
#
#puts apirequest.to_json
#
#apiresponse = JobsAPI.search_jobs(parent, apirequest.to_json)
#
#puts apiresponse