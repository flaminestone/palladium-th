require 'rspec'
require 'net/http'
require 'json'
require 'faker'
require_relative '../../spec/lib/models/AbstractProduct'
require_relative '../../spec/lib/models/AbstractPlan'
require_relative '../../spec/lib/models/AbstractRun'
require_relative '../../spec/lib/models/AbstractResultSet'
require_relative '../../spec/lib/models/AbstractResult'
require_relative '../../spec/lib/models/AbstractStatus'
require_relative '../../spec/lib/models/AbstractSuite'
require_relative '../../spec/lib/models/AbstractSuitePack'
require_relative '../../spec/lib/models/AbstractCase'
require_relative '../../spec/lib/models/AbstractCasePack'
require_relative '../../spec/lib/models/AbstractProductPack'
require_relative '../../spec/lib/models/AbstractPlanPack'
require_relative '../../spec/lib/models/AbstractRunPack'
require_relative '../../spec/lib/models/AbstractResultSetPack'
require_relative '../../spec/lib/models/AbstractResultPack'
require_relative '../../spec/lib/models/AbstractToken'
require_relative '../../spec/lib/models/AbstractTokenPack'
require_relative '../../spec/lib/models/AbstractHistory'
require_relative '../../spec/lib/models/AbstractHistoryPack'

require_relative '../data/static_data'
require_relative '../lib/functions/AuthFunctions'
require_relative '../lib/functions/ProductFunctions'
require_relative '../lib/functions/PlanFunctions'
require_relative '../lib/functions/RunFunctions'
require_relative '../lib/functions/HistoryFunctions'
require_relative '../lib/functions/ResultSetFunctions'
require_relative '../lib/functions/ResultFunctions'
require_relative '../lib/functions/StatusFunctions'
require_relative '../lib/functions/AuthFunctions'
require_relative '../lib/functions/TokenFunctions'
require_relative '../lib/functions/InviteTokenFunctions'
require_relative '../lib/functions/SuiteFunctions'
require_relative '../lib/functions/ProductPositionFunctions.rb'
require_relative '../lib/functions/CaseFunctions'
require_relative '../lib/functions/UserSetting'
require_relative '../lib/functions/AccountFunctions'
require_relative '../../spec/lib/ObjectWrap/http'
class TestManagement
end
