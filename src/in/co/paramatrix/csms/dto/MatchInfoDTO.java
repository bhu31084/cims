/**
 * 
 */
package in.co.paramatrix.csms.dto;

/**
 * @author Microsoft
 *
 */
public class MatchInfoDTO {

	private String matchId;
	private String type;
	private String date;
	private String dateEnd;
	private Integer noOfDays;
	private String gameType;
	private String dayNight;
	private String seriesName;
	private String seriesSeason;
	private String matchName;
	private String overs;
	private String targetscore;
	private String tossWinner;
	private String elected;
	private String resultWinner;
	private String playerofthematch;
	private String matchResult;
	private String matchstate;
	private String city;
	private String refereeName;
	private String team1Id;
	private String team2Id;
	private String team1Name;
	private String team2Name;
	private String inningOne;
	private String inningTwo;
	private String inningThree;
	private String inningFour;
	private String inning1Batting;
	private String inning1Bowling;
	private String inning2Batting;
	private String inning2Bowling;
	private String inning3Batting;
	private String inning3Bowling;
	private String inning4Batting;
	private String inning4Bowling;
	private String venue;
	private String umpire1;
	private String umpire2;
	private String umpire3;
	
	private String inning1BattingScore;
	private String inning2BattingScore;
	private String inning3BattingScore;
	private String inning4BattingScore;
	
	public String getInning1BattingScore() {
		return this.inning1BattingScore;
	}
	public void setInning1BattingScore(String inning1BattingScore) {
		this.inning1BattingScore = inning1BattingScore;
	}
	public String getInning2BattingScore() {
		return this.inning2BattingScore;
	}
	public void setInning2BattingScore(String inning2BattingScore) {
		this.inning2BattingScore = inning2BattingScore;
	}
	public String getInning3BattingScore() {
		return this.inning3BattingScore;
	}
	public void setInning3BattingScore(String inning3BattingScore) {
		this.inning3BattingScore = inning3BattingScore;
	}
	public String getInning4BattingScore() {
		return this.inning4BattingScore;
	}
	public void setInning4BattingScore(String inning4BattingScore) {
		this.inning4BattingScore = inning4BattingScore;
	}
	public String getDateEnd() {
		return this.dateEnd;
	}
	public void setDateEnd(String dateEnd) {
		this.dateEnd = dateEnd;
	}
	public Integer getNoOfDays() {
		return this.noOfDays;
	}
	public void setNoOfDays(Integer noOfDays) {
		this.noOfDays = noOfDays;
	}
	/**
	 * @return the matchId
	 */
	public String getMatchId() {
		return matchId;
	}
	/**
	 * @param matchId the matchId to set
	 */
	public void setMatchId(String matchId) {
		this.matchId = matchId;
	}
	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * @return the date
	 */
	public String getDate() {
		return date;
	}
	/**
	 * @param date the date to set
	 */
	public void setDate(String date) {
		this.date = date;
	}
	/**
	 * @return the gameType
	 */
	public String getGameType() {
		if(gameType==null){
			gameType = "";
		}
		return gameType;
	}
	/**
	 * @param gameType the gameType to set
	 */
	public void setGameType(String gameType) {
		this.gameType = gameType;
	}
	/**
	 * @return the dayNight
	 */
	public String getDayNight() {
		return dayNight;
	}
	/**
	 * @param dayNight the dayNight to set
	 */
	public void setDayNight(String dayNight) {
		this.dayNight = dayNight;
	}
	/**
	 * @return the seriesName
	 */
	public String getSeriesName() {
		if(seriesName==null){
			seriesName = "";
		}
		return seriesName;
	}
	/**
	 * @param seriesName the seriesName to set
	 */
	public void setSeriesName(String seriesName) {
		this.seriesName = seriesName;
	}
	/**
	 * @return the seriesSeason
	 */
	public String getSeriesSeason() {
		return seriesSeason;
	}
	/**
	 * @param seriesSeason the seriesSeason to set
	 */
	public void setSeriesSeason(String seriesSeason) {
		this.seriesSeason = seriesSeason;
	}
	/**
	 * @return the matchName
	 */
	public String getMatchName() {
		return matchName;
	}
	/**
	 * @param matchName the matchName to set
	 */
	public void setMatchName(String matchName) {
		this.matchName = matchName;
	}
	/**
	 * @return the overs
	 */
	public String getOvers() {
		return overs;
	}
	/**
	 * @param overs the overs to set
	 */
	public void setOvers(String overs) {
		this.overs = overs;
	}
	/**
	 * @return the targetscore
	 */
	public String getTargetscore() {
		if(targetscore==null){
			targetscore = "";
		}
		return targetscore;
	}
	/**
	 * @param targetscore the targetscore to set
	 */
	public void setTargetscore(String targetscore) {
		this.targetscore = targetscore;
	}
	/**
	 * @return the tossWinner
	 */
	public String getTossWinner() {
		return tossWinner;
	}
	/**
	 * @param tossWinner the tossWinner to set
	 */
	public void setTossWinner(String tossWinner) {
		this.tossWinner = tossWinner;
	}
	/**
	 * @return the elected
	 */
	public String getElected() {
		return elected;
	}
	/**
	 * @param elected the elected to set
	 */
	public void setElected(String elected) {
		this.elected = elected;
	}
	/**
	 * @return the resultWinner
	 */
	public String getResultWinner() {
		if(resultWinner==null){
			resultWinner = "";
		}
		return resultWinner;
	}
	/**
	 * @param resultWinner the resultWinner to set
	 */
	public void setResultWinner(String resultWinner) {
		this.resultWinner = resultWinner;
	}
	/**
	 * @return the playerofthematch
	 */
	public String getPlayerofthematch() {
		if(playerofthematch==null){
			playerofthematch = "";
		}
		return playerofthematch;
	}
	/**
	 * @param playerofthematch the playerofthematch to set
	 */
	public void setPlayerofthematch(String playerofthematch) {
		this.playerofthematch = playerofthematch;
	}
	/**
	 * @return the matchResult
	 */
	public String getMatchResult() {
		if(matchResult==null){
			matchResult = "";
		}
		return matchResult;
	}
	/**
	 * @param matchResult the matchResult to set
	 */
	public void setMatchResult(String matchResult) {
		this.matchResult = matchResult;
	}
	/**
	 * @return the matchstate
	 */
	public String getMatchstate() {
		if(matchstate==null){
			matchstate = "";
		}
		return matchstate;
	}
	/**
	 * @param matchstate the matchstate to set
	 */
	public void setMatchstate(String matchstate) {
		this.matchstate = matchstate;
	}
	/**
	 * @return the city
	 */
	public String getCity() {
		return city;
	}
	/**
	 * @param city the city to set
	 */
	public void setCity(String city) {
		this.city = city;
	}
	/**
	 * @return the refereeName
	 */
	public String getRefereeName() {
		return refereeName;
	}
	/**
	 * @param refereeName the refereeName to set
	 */
	public void setRefereeName(String refereeName) {
		this.refereeName = refereeName;
	}
	/**
	 * @return the team1Id
	 */
	public String getTeam1Id() {
		return team1Id;
	}
	/**
	 * @param team1Id the team1Id to set
	 */
	public void setTeam1Id(String team1Id) {
		this.team1Id = team1Id;
	}
	/**
	 * @return the team2Id
	 */
	public String getTeam2Id() {
		return team2Id;
	}
	/**
	 * @param team2Id the team2Id to set
	 */
	public void setTeam2Id(String team2Id) {
		this.team2Id = team2Id;
	}
	/**
	 * @return the team1Name
	 */
	public String getTeam1Name() {
		return team1Name;
	}
	/**
	 * @param team1Name the team1Name to set
	 */
	public void setTeam1Name(String team1Name) {
		this.team1Name = team1Name;
	}
	/**
	 * @return the team2Name
	 */
	public String getTeam2Name() {
		return team2Name;
	}
	/**
	 * @param team2Name the team2Name to set
	 */
	public void setTeam2Name(String team2Name) {
		this.team2Name = team2Name;
	}
	/**
	 * @return the inningOne
	 */
	public String getInningOne() {
		return inningOne;
	}
	/**
	 * @param inningOne the inningOne to set
	 */
	public void setInningOne(String inningOne) {
		this.inningOne = inningOne;
	}
	/**
	 * @return the inningTwo
	 */
	public String getInningTwo() {
		return inningTwo;
	}
	/**
	 * @param inningTwo the inningTwo to set
	 */
	public void setInningTwo(String inningTwo) {
		this.inningTwo = inningTwo;
	}
	/**
	 * @return the inningThree
	 */
	public String getInningThree() {
		return inningThree;
	}
	/**
	 * @param inningThree the inningThree to set
	 */
	public void setInningThree(String inningThree) {
		this.inningThree = inningThree;
	}
	/**
	 * @return the inningFour
	 */
	public String getInningFour() {
		return inningFour;
	}
	/**
	 * @param inningFour the inningFour to set
	 */
	public void setInningFour(String inningFour) {
		this.inningFour = inningFour;
	}
	/**
	 * @return the inning1Batting
	 */
	public String getInning1Batting() {
		return inning1Batting;
	}
	/**
	 * @param inning1Batting the inning1Batting to set
	 */
	public void setInning1Batting(String inning1Batting) {
		this.inning1Batting = inning1Batting;
	}
	/**
	 * @return the inning1Bowling
	 */
	public String getInning1Bowling() {
		return inning1Bowling;
	}
	/**
	 * @param inning1Bowling the inning1Bowling to set
	 */
	public void setInning1Bowling(String inning1Bowling) {
		this.inning1Bowling = inning1Bowling;
	}
	/**
	 * @return the inning2Batting
	 */
	public String getInning2Batting() {
		return inning2Batting;
	}
	/**
	 * @param inning2Batting the inning2Batting to set
	 */
	public void setInning2Batting(String inning2Batting) {
		this.inning2Batting = inning2Batting;
	}
	/**
	 * @return the inning2Bowling
	 */
	public String getInning2Bowling() {
		return inning2Bowling;
	}
	/**
	 * @param inning2Bowling the inning2Bowling to set
	 */
	public void setInning2Bowling(String inning2Bowling) {
		this.inning2Bowling = inning2Bowling;
	}
	/**
	 * @return the inning3Batting
	 */
	public String getInning3Batting() {
		return inning3Batting;
	}
	/**
	 * @param inning3Batting the inning3Batting to set
	 */
	public void setInning3Batting(String inning3Batting) {
		this.inning3Batting = inning3Batting;
	}
	/**
	 * @return the inning3Bowling
	 */
	public String getInning3Bowling() {
		return inning3Bowling;
	}
	/**
	 * @param inning3Bowling the inning3Bowling to set
	 */
	public void setInning3Bowling(String inning3Bowling) {
		this.inning3Bowling = inning3Bowling;
	}
	/**
	 * @return the inning4Batting
	 */
	public String getInning4Batting() {
		return inning4Batting;
	}
	/**
	 * @param inning4Batting the inning4Batting to set
	 */
	public void setInning4Batting(String inning4Batting) {
		this.inning4Batting = inning4Batting;
	}
	/**
	 * @return the inning4Bowling
	 */
	public String getInning4Bowling() {
		return inning4Bowling;
	}
	/**
	 * @param inning4Bowling the inning4Bowling to set
	 */
	public void setInning4Bowling(String inning4Bowling) {
		this.inning4Bowling = inning4Bowling;
	}
	/**
	 * @return the venue
	 */
	public String getVenue() {
		if(venue==null){
			venue = "";
		}
		return venue;
	}
	/**
	 * @param venue the venue to set
	 */
	public void setVenue(String venue) {
		this.venue = venue;
	}
	/**
	 * @return the umpire1
	 */
	public String getUmpire1() {
		if(umpire1==null){
			umpire1 = "";
		}
		return umpire1;
	}
	/**
	 * @param umpire1 the umpire1 to set
	 */
	public void setUmpire1(String umpire1) {
		this.umpire1 = umpire1;
	}
	/**
	 * @return the umpire2
	 */
	public String getUmpire2() {
		if(umpire2==null){
			umpire2 = "";
		}
		return umpire2;
	}
	/**
	 * @param umpire2 the umpire2 to set
	 */
	public void setUmpire2(String umpire2) {
		this.umpire2 = umpire2;
	}
	/**
	 * @return the umpire3
	 */
	public String getUmpire3() {
		if(umpire3==null){
			umpire3 = "";
		}
		return umpire3;
	}
	/**
	 * @param umpire3 the umpire3 to set
	 */
	public void setUmpire3(String umpire3) {
		this.umpire3 = umpire3;
	}
	
	
	
	
	
}
