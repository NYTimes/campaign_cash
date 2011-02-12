module CampaignCash
  class Candidate < Base
    
    attr_reader :name, :id, :state, :district, :party, :fec_uri, :committee, 
                :mailing_city, :mailing_address, :mailing_state, :mailing_zip,
                :total_receipts, :total_contributions, :total_from_individuals, 
                :total_from_pacs, :candidate_loans, :total_disbursements,
                :total_refunds, :debts_owed, :begin_cash, :end_cash, :status,
                :date_coverage_to, :date_coverage_from, :relative_uri
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
		def self.create(params={})
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
		
		def self.create_from_search_results(params={})
		  self.new :name => params['candidate']['name'],
		           :id => params['candidate']['id'],
		           :state => params['state'],
		           :district => params['district'],
		           :party => params['candidate']['party'],
		           :relative_uri => params['candidate']['relative_uri'],
		           :committee => params['committee']
		  
		end

    def self.find(fecid, cycle=CURRENT_CYCLE)
			reply = invoke("#{cycle}/candidates/#{fecid}")
			result = reply['results']
			self.create(result.first) if result.first
    end
    
    def self.leaders(category, cycle=CURRENT_CYCLE)
			reply = invoke("#{cycle}/candidates/leaders/#{category}",{})
			results = reply['results']
      results.map{|c| self.create(c)}
    end
    
    def self.search(name, cycle=CURRENT_CYCLE)
			reply = invoke("#{cycle}/candidates/search", {:query => name})
			results = reply['results']      
      results.map{|c| self.create_from_search_results(c)}
    end
    
    def self.new_candidates(cycle=CURRENT_CYCLE)
			reply = invoke("#{cycle}/candidates/new",{})
			results = reply['results']      
      results.map{|c| self.create(c)}      
    end
    
    def self.state_chamber(state, chamber, district=nil, cycle=CURRENT_CYCLE)
      district ? path = "#{cycle}/seats/#{state}/#{chamber}/#{district}" : path = "#{cycle}/seats/#{state}/#{chamber}"
			reply = invoke(path,{})
			results = reply['results']
      results.map{|c| self.create_from_search_results(c)}      
    end
    
  end
end
