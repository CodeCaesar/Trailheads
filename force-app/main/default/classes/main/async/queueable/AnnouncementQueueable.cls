/**
 * @name AnnouncementQueueable
 * @description This class posts Chatter Announcements
**/
public class AnnouncementQueueable implements Queueable, Database.AllowsCallouts{

    public List<ConnectApi.AnnouncementInput> toPost;

    public AnnouncementQueueable() {
    }
    //ToDo: Modify this class to implement the Queueable interface and call the postAnnouncements method

    public void execute(QueueableContext context) {
        if (toPost != null) {
            for (ConnectApi.AnnouncementInput thisAnnouncement : toPost) {
                ConnectApi.Announcements.postAnnouncement('superbadge', thisAnnouncement);
            }
        }

    }
    /**
     * @name postAnnouncements
     * @description This method is provided for you to facilitate the Super Badge
    **/
    public static void PostAnnouncements(List<ConnectApi.AnnouncementInput> announcements){
        while ( announcements.size() > 0 ){
            if ( Limits.getDMLStatements() < Limits.getLimitDMLStatements() && !test.isRunningTest() ){
                ConnectApi.AnnouncementInput a = announcements.remove(0);
                ConnectApi.Announcements.postAnnouncement('Internal', a);
            } else {
                break;
            }
        }
        if ( announcements.size() > 0 && !test.isRunningTest() ){
            AnnouncementQueueable q = new AnnouncementQueueable();
            q.toPost = announcements;
            System.enqueueJob(new AnnouncementQueueable());

            //ToDo: Enqueue the above instance of announcementQueueable
        }
    }

    // public static void createAnnouncement(String groupId, String message, Date expirationDate) {
    //     ConnectApi.AnnouncementInput announcementInput = new ConnectApi.AnnouncementInput();
    //     announcementInput.body = new ConnectApi.MessageBodyInput();
    //     announcementInput.body.messageSegments = new List<ConnectApi.MessageSegmentInput>();
    //     ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
    //     textSegment.text = message;
    //     announcementInput.body.messageSegments.add(textSegment);
    //     announcementInput.expirationDate = expirationDate;

    //     // Create the announcement in the specified Chatter group
    //     ConnectApi.Announcement announcement = ConnectApi.ChatterFeeds.postAnnouncement(
    //         null, ConnectApi.FeedType.Record, groupId, announcementInput
    //     );

    //     System.debug('Announcement created: ' + announcement.id);
    // }

}