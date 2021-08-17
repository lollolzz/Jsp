package Kr.co.jboard1.db;

public class Sql {
	// Sql 작성시 띄어쓰기도 조심해야 한다.
	// run 작동시 이유없이 오류가 발생한다면 서버clean 해보고 Sql문을 점검해보자 
	
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
	
	
	// 게시판 관련 
	public static final String SELECT_COUNT_TOTAL = "SELECT COUNT(`seq`) FROM `Jboard_article`;";
	public static final String SELECT_ARTICLES = "SELECT a.*, b.nick FROM `Jboard_article` AS a "
												+ "JOIN `Jboard_member` AS b "
												+ "ON a.uid = b.uid "
												+ "ORDER BY `seq` DESC "
												+ "LIMIT ?, 10;";
	// member 와 article를 join한 이유는 글쓴이의 이름을 닉네임으로 바꾸기 위함이다.
	// order by `seq` DESC는 높은 순서부터 낮은 순 으로 정렬하기 위함 이다 
	// LIMIT - 10은 게시판 한 페이지마다 10개의 글들을 업로드 시키겟다는 표현이다 .
	
	public static final String SELECT_MAX_SEQ = "SELECT MAX(`seq`) FROM `Jboard_article`;";
	
	public static final String INSERT_ARTICLE = "INSERT INTO `Jboard_article` SET "
												+ "`title`=?,"
												+ "`content`=?,"
												+ "`file`=?,"
												+ "`uid`=?,"
												+ "`regip`=?,"
												+ "`rdate`=NOW();";
	
	public static final String INSERT_FILE = "INSERT INTO `Jboard_file` SET "
											+ "`parent`=?,"
											+ "`oriName`=?,"
											+ "`newName`=?,"
											+ "`rdate`=NOW();";
	
}