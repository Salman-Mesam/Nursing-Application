import java.nio.charset.Charset;
import java.sql.* ;
import java.util.ArrayList;
import java.util.Random;
import java.util.Scanner;


class GoBabbyApp {


    private static Scanner sc = new Scanner(System.in);
    private static boolean notFinished = true;

    public static void main ( String [ ] args ) throws SQLException
    {
        // Unique table names.  Either the user supplies a unique identifier as a command line argument, or the program makes one up.
        String tableName = "";
        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        if ( args.length > 0 )
            tableName += args [ 0 ] ;
        else
            tableName += "exampletbl";

        // Register the driver.  You must register the driver before you can use it.
        try { DriverManager.registerDriver ( new com.ibm.db2.jcc.DB2Driver() ) ; }
        catch (Exception cnfe){ System.out.println("Class not found"); }

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = null;
        String your_password = null;
        //AS AN ALTERNATIVE, you can just set your password in the shell environment in the Unix (as shown below) and read it from there.
        //$  export SOCSPASSWD=yoursocspasswd
        if(your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null)
        {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        if(your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null)
        {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
        Statement statement = con.createStatement ( ) ;

        //Start my logic here
        while(notFinished) {
            System.out.println("---------- WELCOME MidWife ----------");
            System.out.println("Please enter your practitioner id [E] to exit:");

            //Now I have my Practioner Id being read in
            String practionerId = sc.nextLine();

            if(practionerId.equals("E")) {
                System.out.println("Exiting Program...");
                sc.close();
                statement.close();
                con.close();
                notFinished=false;
                break;
            }


            boolean exists = checkPracIdValidity(statement,practionerId);

            if(!exists) {
                System.out.println("No Midwife found for PractitionerId provided! ");
            }

            //return back to same menu --check how to handle


            //if i got a pract id I need to check if it is valid or not

            if (exists){
                boolean doneFix =  true;
                while(doneFix){
                    System.out.println("Provide date (YYYY-MM-DD) to obtain appointment info [E] to exit:");
                    String date = sc.nextLine();

                    if(date.equals("E")) {
                        System.out.println("Exit");
                        sc.close();
                        statement.close();
                        con.close();
                        notFinished=false;
                        break;
                    }


                    try {
                        PreparedStatement getAppSQL = con.prepareStatement("select PREGNANCY.APPID,DATE,TIME,APPOINTMENTS.PRACTITIONERID,TYPE,PREGNANCYID,Mother.MOTHERID,MOTHER.NAME,QHI from APPOINTMENTS JOIN MIDWIFE ON APPOINTMENTS.PRACTITIONERID=MIDWIFE.PRACTITIONERID\n" +
                                "JOIN\n" +
                                "PREGNANCY ON PREGNANCY.PRACTITIONERID=APPOINTMENTS.PRACTITIONERID AND PREGNANCY.APPID=APPOINTMENTS.APPID\n" +
                                "JOIN\n" +
                                "MOTHER ON MOTHER.MOTHERID=PREGNANCY.MOTHERID\n" +
                                "WHERE DATE =? AND APPOINTMENTS.PRACTITIONERID=?\n" +
                                "ORDER BY TIME");
                        getAppSQL.setDate(1, Date.valueOf(date));
                        getAppSQL.setString(2, practionerId);

                        ResultSet rs = getAppSQL.executeQuery();





                        boolean recordsFoundForDate = false;
                        int count = 0;

                        //nEED TO store these details for future use
                        ArrayList<String> types = new ArrayList<String>();
                        ArrayList<String> names = new ArrayList<String>();
                        ArrayList<String> QHIs = new ArrayList<String>();
                        ArrayList<String> pregnancyIds = new ArrayList<String>();
                        ArrayList<String> appIds = new ArrayList<String>();
                        ArrayList<String> momIds = new ArrayList<String>();




                        while (rs.next()) {


                            //sTORING SOME DETAILS FOR FUTURE USE
                            types.add(rs.getString("TYPE"));
                            names.add(rs.getString("NAME"));
                            QHIs.add(rs.getString("QHI"));
                            pregnancyIds.add(rs.getString("PREGNANCYID"));
                            appIds.add(rs.getString("APPID"));
                            momIds.add(rs.getString("MOTHERID"));

                            count++;


                            String B = "B";
                            String P = "P";

                            if(rs.getString("TYPE").equals("Backup")){
                                System.out.println(count+":  " + rs.getDate("DATE")+ "  " + B + "  " + rs.getString("NAME") + "  " + rs.getString("QHI") );
                            }else{
                                System.out.println(count+":  " + rs.getDate("DATE")+ "  " + P + "  " + rs.getString("NAME") + "  " + rs.getString("QHI") );
                            }

                            recordsFoundForDate=true;


                        }

                        if (!recordsFoundForDate){
                            System.out.println("No records found for this date");
                        }


                        if(recordsFoundForDate){
                            while(true){
                                System.out.println("Enter the appointment number that you would like to work on.\n" +
                                        "[E] to exit [D] to go back to another date :");

                                String nextInstruction = sc.nextLine();

                                if(nextInstruction.equals("D")) {
                                    System.out.println("Going Back to another Date");
                                    break;
                                }else if(nextInstruction.equals("E")) {
                                    System.out.println("Exit");
                                    sc.close();
                                    statement.close();
                                    con.close();
                                    notFinished=false;
                                    doneFix =false;
                                    break;

                                }else{
                                    //More Options
                                    int index = Integer.parseInt(nextInstruction)-1;



                                    String name = names.get(index);
                                    String qhi = QHIs.get(index);
                                    String aId = appIds.get(index);
                                    String pregId = pregnancyIds.get(index);
                                    String momId =momIds.get(index);
                                    System.out.println("For" + " " + name + " " + qhi);



                                    while(true){
                                        System.out.println("1 - Review Notes");
                                        System.out.println("2 - Review Tests");
                                        System.out.println("3 - Add a Note");
                                        System.out.println("4 - Prescribe a Test");
                                        System.out.println("5 - Go Back to Appointnments");
                                        System.out.println("Enter Your choice : ");

                                        int choice = sc.nextInt();
                                        boolean notesFoundForAppointment = false;
                                        boolean testsFoundForAppointment = false;

                                        if (choice==5){
                                            sc.nextLine();
                                            saveAndPrint(statement,con,date,practionerId);
                                            break;
                                        }


                                        switch(choice) {
                                            case 1:
                                                System.out.println("Here are the notes assosciated to this pregnancy:");

                                                PreparedStatement getNotesSQL = con.prepareStatement("SELECT TIMESTAMP , DETAILS, OBSERVATION FROM Notes WHERE APPID =? ORDER BY TIMESTAMP DESC ");
                                                getNotesSQL.setString(1, aId);

                                                ResultSet rs2 = getNotesSQL.executeQuery();

                                                while (rs2.next()) {
                                                    Time timestamp = rs2.getTime("TIMESTAMP");
                                                    String detail = rs2.getString("DETAILS");
                                                    String obs = rs2.getString("OBSERVATION");

                                                    Date d=new Date(timestamp.getTime());
                                                    Time t= new Time(timestamp.getTime());
                                                    System.out.println( d + " " + t + "   " + detail + "    " + obs);
                                                    notesFoundForAppointment = true;
                                                }

                                                if (!notesFoundForAppointment){
                                                    System.out.println("No notes found for this appointment");
                                                }

                                                break;

                                            case 2:
                                                System.out.println("Here are the tests assosciated to this pregnancy:");

                                                PreparedStatement getTestsSQL = con.prepareStatement("select PRESCRIBEDDATE,TYPE,RESULTDESCRIPTION from test where PREGNANCYID=? order by PRESCRIBEDDATE DESC");
                                                getTestsSQL.setString(1, pregId);

                                                ResultSet rs3 = getTestsSQL.executeQuery();


                                                while (rs3.next()) {
                                                    Date d = rs3.getDate("PRESCRIBEDDATE");
                                                    String testType = rs3.getString("TYPE");
                                                    String result_desc = rs3.getString("RESULTDESCRIPTION");


                                                    if (result_desc.equals("UNAVAILABLE")){
                                                        System.out.println( d + " "  + "["+testType+"]" + "  " + "PENDING");
                                                    }else
                                                    {
                                                        System.out.println( d + " "  + "["+testType+"]" + "  " + result_desc);
                                                    }

                                                    testsFoundForAppointment = true;
                                                }

                                                if (!testsFoundForAppointment){
                                                    System.out.println("No tests found for this appointment");
                                                }

                                                break;

                                            case 3:
                                                System.out.println("\nPlease type your observation:\n");
                                                sc.nextLine();
                                                String obs = sc.nextLine();
                                                Random rand = new Random();
                                                int NoteId = rand.nextInt(5000);
                                                Timestamp t = new Timestamp(System.currentTimeMillis());
                                                String d = "Details will come at a future date";
                                                //appId I already have it


                                                PreparedStatement insertNoteSQL = con.prepareStatement("INSERT INTO Notes (NOTEID,"
                                                        + "TIMESTAMP , DETAILS, OBSERVATION, APPID) VALUES (?, ?, ?, ?, ?)");

                                                insertNoteSQL.setInt(1, NoteId);
                                                insertNoteSQL.setTimestamp(2, t);
                                                insertNoteSQL.setString(3, d);
                                                insertNoteSQL.setString(4, obs);
                                                insertNoteSQL.setString(5, aId);
                                                insertNoteSQL.executeUpdate();

                                                break;

                                            case 4:
                                                System.out.println("\nPlease enter the type of test:\n");
                                                sc.nextLine();
                                                String type = sc.nextLine();
                                                Random rand2 = new Random();
                                                int TestId = rand2.nextInt(5000);
                                                long now = System.currentTimeMillis();


                                                Date date1 = new Date(now);




                                                //appId I already have it


                                                PreparedStatement insertTestSQL = con.prepareStatement("INSERT INTO TEST (TESTID,"
                                                        + "TYPE , PRESCRIBEDDATE, LABCONDUCTDATE, SAMPLEDATE, RESULTDESCRIPTION, PREGNANCYID,PRACTIONERID,TECHNICIANID) VALUES (?,?,?,?,?,?,?,?,?)");

                                                insertTestSQL.setInt(1, TestId);
                                                insertTestSQL.setString(2, type);
                                                insertTestSQL.setDate(3, date1);
                                                insertTestSQL.setDate(4,date1);
                                                insertTestSQL.setDate(5, date1);
                                                insertTestSQL.setString(6, "PENDING");
                                                insertTestSQL.setString(7, pregId);
                                                insertTestSQL.setString(8, practionerId);
                                                insertTestSQL.setString(9, null);
                                                insertTestSQL.executeUpdate();

                                                break;






                                        }


                                    }

                                }
                            }
                        }





                    }  catch (SQLException e) {
                        sqlCode = e.getErrorCode(); // Get SQLCODE
                        sqlState = e.getSQLState(); // Get SQLSTATE

                        // Your code to handle errors comes here;
                        // something more meaningful than a print would be good
                        sc.close();
                        statement.close();
                        con.close();
                        System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                        System.out.println(e);

                    }


                }
            }

        }



        //end logic

        // Finally but importantly close the statement and connection
        statement.close ( ) ;
        con.close ( ) ;


    }


    private static void saveAndPrint (Statement s,Connection con,String d,String pracId) throws SQLException {
        try{
            PreparedStatement getAppSQL = con.prepareStatement("select PREGNANCY.APPID,DATE,TIME,APPOINTMENTS.PRACTITIONERID,TYPE,PREGNANCYID,Mother.MOTHERID,MOTHER.NAME,QHI from APPOINTMENTS JOIN MIDWIFE ON APPOINTMENTS.PRACTITIONERID=MIDWIFE.PRACTITIONERID\n" +
                    "JOIN\n" +
                    "PREGNANCY ON PREGNANCY.PRACTITIONERID=APPOINTMENTS.PRACTITIONERID AND PREGNANCY.APPID=APPOINTMENTS.APPID\n" +
                    "JOIN\n" +
                    "MOTHER ON MOTHER.MOTHERID=PREGNANCY.MOTHERID\n" +
                    "WHERE DATE =? AND APPOINTMENTS.PRACTITIONERID=?\n" +
                    "ORDER BY TIME");
            getAppSQL.setDate(1, Date.valueOf(d));
            getAppSQL.setString(2, pracId);

            ResultSet rs = getAppSQL.executeQuery();


            boolean recordsFoundForDate = false;
            int count = 0;

            //nEED TO store these details for future use
            ArrayList<String> types = new ArrayList<String>();
            ArrayList<String> names = new ArrayList<String>();
            ArrayList<String> QHIs = new ArrayList<String>();
            ArrayList<String> pregnancyIds = new ArrayList<String>();
            ArrayList<String> appIds = new ArrayList<String>();
            ArrayList<String> momIds = new ArrayList<String>();


            while (rs.next()) {


                //sTORING SOME DETAILS FOR FUTURE USE
                types.add(rs.getString("TYPE"));
                names.add(rs.getString("NAME"));
                QHIs.add(rs.getString("QHI"));
                pregnancyIds.add(rs.getString("PREGNANCYID"));
                appIds.add(rs.getString("APPID"));
                momIds.add(rs.getString("MOTHERID"));

                count++;


                String B = "B";
                String P = "P";

                if(rs.getString("TYPE").equals("Backup")){
                    System.out.println(count+":  " + rs.getDate("DATE")+ "  " + B + "  " + rs.getString("NAME") + "  " + rs.getString("QHI") );
                }else{
                    System.out.println(count+":  " + rs.getDate("DATE")+ "  " + P + "  " + rs.getString("NAME") + "  " + rs.getString("QHI") );
                }

                recordsFoundForDate=true;


            }







        }catch (SQLException e) {
            int sqlCode=0;      // Variable to hold SQLCODE
            String sqlState="00000";  // Variable to hold SQLSTATE
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            sc.close();
            s.close();
            con.close();
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);

        }
    }

    private static boolean checkPracIdValidity(Statement s, String pracId) {
        boolean  valid  = false;
        try {
            String validityCheckQuery = "SELECT PRACTITIONERID FROM MIDWIFE WHERE PRACTITIONERID=" + pracId;
            ResultSet rs = s.executeQuery(validityCheckQuery);

            while (rs.next()) {
                pracId = rs.getString("PRACTITIONERID");
                valid = true;
            }



        } catch (SQLException e) {

            int sqlCode=0;      // Variable to hold SQLCODE
            String sqlState="00000";  // Variable to hold SQLSTATE
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
        }


        return valid;
    }


}

