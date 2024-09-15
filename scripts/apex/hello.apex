orderExtension ext = new orderExtension(new apexPages.standardController(new Order()));
system.assert( ext.gethasNext() == true , 'ext.getHasNext() did not return the expected result.' );
system.assert( ext.gethasPrevious() == false, 'ext.gethasPrevious() did not return the expected result.' );
system.assert( ext.getTotalPages() == 3, 'ext.getTotalPages() did not return the expected result.' );
system.assert( ext.getPageNumber() == 1, 'ext.getPageNumber() did not return the expected result.' );

ext.next();
system.assert( ext.gethasNext() == true, 'ext.getHasNext() did not return the expected result.' );
system.assert( ext.gethasPrevious() == true, 'ext.gethasPrevious() did not return the expected result.' );
system.assert( ext.gettotalPages() == 3, 'ext.getTotalPages() did not return the expected result.' );
system.assert( ext.getPageNumber() == 2, 'ext.getPageNumber() did not return the expected result.'  );

ext.last();
system.assert( ext.gethasNext() == false, 'ext.getHasNext() did not return the expected result.' );
system.assert( ext.gethasPrevious() == true, 'ext.gethasPrevious() did not return the expected result.' );
system.assert( ext.gettotalPages() == 3, 'ext.getTotalPages() did not return the expected result.' );
system.assert( ext.getPageNumber() == 3, 'ext.getPageNumber() did not return the expected result.'  );

ext.previous();
system.assert( ext.gethasNext() == true, 'ext.getHasNext() did not return the expected result.' );
system.assert( ext.gethasPrevious() == true, 'ext.gethasPrevious() did not return the expected result.' );
system.assert( ext.gettotalPages() == 3, 'ext.getTotalPages() did not return the expected result.' );
system.assert( ext.getPageNumber() == 2, 'ext.getPageNumber() did not return the expected result.'  );

ext.first();
system.assert( ext.gethasNext() == true, 'ext.getHasNext() did not return the expected result.' );
system.assert( ext.gethasPrevious() == false, 'ext.gethasPrevious() did not return the expected result.' );
system.assert( ext.gettotalPages() == 3, 'ext.getTotalPages() did not return the expected result.' );
system.assert( ext.getPageNumber() == 1, 'ext.getPageNumber() did not return the expected result.'  );

CSUtils.debugSObjectList(PricebookEntriesSelector.newInstance().selectAll());