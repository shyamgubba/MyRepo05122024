public with sharing class SOSLController {
    public class SearchResultsWrapper {
        @AuraEnabled public String objectName;
        @AuraEnabled public List<SObject> records;

        public SearchResultsWrapper(String objectName, List<SObject> records) {
            this.objectName = objectName;
            this.records = records;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<SearchResultsWrapper> performSOSLQuery(String searchTerm) {
        String soslQuery = 'FIND \'' + searchTerm + '*\' IN ALL FIELDS RETURNING Contact(Name), Lead(Name), Opportunity(Name)';
        List<List<SObject>> searchResults = search.query(soslQuery);

        List<SearchResultsWrapper> wrapperList = new List<SearchResultsWrapper>();
        wrapperList.add(new SearchResultsWrapper('Contact', searchResults[0]));
        wrapperList.add(new SearchResultsWrapper('Lead', searchResults[1]));
        wrapperList.add(new SearchResultsWrapper('Opportunity', searchResults[2]));

        return wrapperList;
    }
}