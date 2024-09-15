public class PricebookEntriesSelector extends fflib_SObjectSelector implements IPricebookEntriesSelector {
    public static IPricebookEntriesSelector newInstance() {
      return (IPricebookEntriesSelector) Application.Selector.newInstance(
        PricebookEntry.SObjectType
      );
    }
  
    public List<Schema.SObjectField> getSObjectFieldList() {
      return new List<Schema.SObjectField>{
        PricebookEntry.Id,
        PricebookEntry.Pricebook2Id,
        PricebookEntry.Product2Id,
        PricebookEntry.UnitPrice,
        PricebookEntry.IsActive,
        PricebookEntry.UseStandardPrice,
        PricebookEntry.ProductFamily__c
      };
    }
  
    public Schema.SObjectType getSObjectType() {
      return PricebookEntry.SObjectType;
    }
  
    public List<PricebookEntry> selectAll() {
      return (List<PricebookEntry>) Database.query(newQueryFactory().toSOQL());
    }
  
    public List<PricebookEntry> selectByProductAndPricebook(Id productId, Id pricebookId) {
      return (List<PricebookEntry>) Database.query(
        newQueryFactory()
          .setCondition('Product2Id =: productId')
          .setCondition('Pricebook2Id =: pricebookId')
          .toSOQL()
      );
    }
    public List<PricebookEntry> selectByPricebook(Id pricebookId) {
      return (List<PricebookEntry>) Database.query(
        newQueryFactory()
          .setCondition('Pricebook2Id =: pricebookId')
          .toSOQL()
      );
    }

    public List<PricebookEntry> selectByProduct2AndFamily(Set<ID> priceBookIdSet, List<String> familyList) {
      fflib_QueryFactory pricebookEntryQueryFactory = newQueryFactory();
      Boolean pricebookTrue = false;
      Boolean familyListTrue = false;
      if (priceBookIdSet != null && priceBookIdSet.size() > 0) {
        pricebookTrue = true;
        
      }
      if (familyList != null && familyList.size() > 0) {
        familyListTrue = true;
      }
      if (pricebookTrue && !familyListTrue) pricebookEntryQueryFactory.setCondition('Pricebook2Id in: priceBookIdSet AND IsActive = true');
      if (!pricebookTrue && familyListTrue) pricebookEntryQueryFactory.setCondition('ProductFamily__c in: familyList AND IsActive = true');
      if (pricebookTrue && familyListTrue) pricebookEntryQueryFactory.setCondition('ProductFamily__c in: familyList AND Pricebook2Id in: priceBookIdSet AND IsActive = true');
      if (!pricebookTrue && !familyListTrue) pricebookEntryQueryFactory.setCondition('IsActive = true');
      System.debug(pricebookEntryQueryFactory.toSOQL());
      System.debug(familyList.size());
      return (List<PricebookEntry>) Database.query(
        pricebookEntryQueryFactory.toSOQL()
      );
    }
}