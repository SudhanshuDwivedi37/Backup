trigger creatingMenuDetails on Order (after insert, after update)
{
    // Get all related opportunities from orders
    Set<Id> opportunityIds = new Set<Id>();
    List<Order> orderList = new List<Order>();
    for(Order o : Trigger.new)
    {
        if(o.Opportunity__c != NULL)
        {
            opportunityIds.add(o.Opportunity__c);
            orderList.add(o);
        }
    }

    // Query for all opportunities with their related opportunity line items
    Map<Id, Opportunity> oppsWithLineItems = new Map<Id, Opportunity>([SELECT Id, (SELECT Description,Id,ListPrice,Name,OpportunityId,Product2Id,ProductCode,Quantity,TotalPrice,UnitPrice FROM OpportunityLineItems) from Opportunity WHERE Id IN :opportunityIds]);

    if(opportunityIds.size() > 0)
    {
        // Loop through orders
        List<OrderItem> orderItemsForInsert = new List<OrderItem>();
        for(Order o : orderList)
        {
            // For each order get the related opportunity and line items, loop through the line items and add a new order line item to the order line item list for each matching opportunity line item
            Opportunity oppWithLineItem = oppsWithLineItems.get(o.Opportunity__c);
            for(OpportunityLineItem oli : oppWithLineItem.OpportunityLineItems)
            {
                orderItemsForInsert.add(new OrderItem(OrderId=o.Id, PricebookEntryId ='Standard'  , Quantity = 10, UnitPrice=100));
            }
        }
        // If we have order line items, insert data
        if(orderItemsForInsert.size() > 0)
        {
            insert orderItemsForInsert;
        }
    }
}