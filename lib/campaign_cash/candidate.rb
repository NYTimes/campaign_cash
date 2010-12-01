module CampaignCash
  class Candidate < Base
    
    attr_reader :name, :id, :state, :district, :party, :fec_uri, :committee, 
                :mailing_city, :mailing_address, :mailing_state, :mailing_zip,
                :total_receipts, :total_contributions, :total_from_individuals, 
                :total_from_pacs, :candidate_loans, :total_disbursements,
                :total_refunds, :debts_owed, :begin_cash, :end_cash, :status,
                :date_coverage_to, :date_coverage_from
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
		def self.create_from_api(params={})
			self.new :name => params['name'],
							 :id => params['id'],
							 :state => params['state'],
							 :district => params['district'],
							 :party => params['party'],
							 :fec_uri => params['fec_uri'],
							 :committee => params['committee'],
							 :mailing_city => params['mailing_city'],
							 :mailing_address => params['mailing_address'],
							 :mailing_state => params['mailing_state'],
							 :mailing_zip => params['mailing_zip'],
							 :total_receipts => params['total_receipts'],
							 :total_contributions => params['total_contributions'],
							 :total_from_individuals => params['total_from_individuals'],
							 :total_from_pacs => params['total_from_pacs'],
							 :candidate_loans => params['candidate_loans'],
							 :total_disbursements => params['total_disbursements'],
							 :total_refunds => params['total_refunds'],
							 :debts_owed => params['debts_owed'],
							 :begin_cash => params['begin_cash'],
							 :end_cash => params['end_cash'],
							 :status => params['status'],
							 :date_coverage_from => params['date_coverage_from'],
							 :date_coverage_to => params['date_coverage_to'] 
		end
    
    def self.find_by_fecid(cycle, fecid)
      
			reply = invoke("#{cycle}/candidates/#{fecid}")
			result = reply['results']
			self.create_from_api(result.first) if result.first
      
    end
    
    
  end
end
