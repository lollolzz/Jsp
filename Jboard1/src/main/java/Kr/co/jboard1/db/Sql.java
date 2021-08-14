package Kr.co.jboard1.db;

public class Sql {

	
	public static final String SELECT_TERMS = "SELECT * FROM `Jboard_terms`;";
	public static final String SELECT_MEMBER = "SELECT * FROM `Jboard_member` WHERE `uid`=? AND `pass`=PASSWORD(?);";  
	public static final String INSERT_MEMBER = "INSERT INTO `Jboard_member` SET "
												    +"`uid`=?,"
												    +"`pass`=PASSWORD(?),"
												    +"`name`=?,"
												    +"`nick`=?,"
												    +"`email`=?,"
												    +"`hp`=?,"
												    +"`zip`=?,"
												    +"`addr1`=?,"
												    +"`addr2`=?,"
												    +"`regip`=?,"
												    +"`rdate`=NOW();";

	public static final String SELECT_COUNT_UID   = "SELECT COUNT(`uid`)   FROM `Jboard_member` WHERE `uid`=?;";
	public static final String SELECT_COUNT_NICK  = "SELECT COUNT(`nick`)  FROM `Jboard_member` WHERE `nick`=?;";
	public static final String SELECT_COUNT_HP    = "SELECT COUNT(`hp`)    FROM `Jboard_member` WHERE `hp`=?;";
	public static final String SELECT_COUNT_EMAIL = "SELECT COUNT(`email`) FROM `Jboard_member` WHERE `email`=?;";
}