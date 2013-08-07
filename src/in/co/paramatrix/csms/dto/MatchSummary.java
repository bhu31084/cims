/**
 * 
 */
package in.co.paramatrix.csms.dto;

/**
 * @author Microsoft
 *
 */
public class MatchSummary {

	private String teamRun;
	private String teamWicket;
	private String teamOver;
	private String teamRate;
	private String teamExtra;
	private String teamWide;
	private String teamNo;
	private String teamLegBye;
	private String teamBye;
	/**
	 * @return the teamRun
	 */
	public String getTeamRun() {
		if(teamRun==null){
			teamRun = "";
		}
		return teamRun;
	}
	/**
	 * @param teamRun the teamRun to set
	 */
	public void setTeamRun(String teamRun) {
		this.teamRun = teamRun;
	}
	/**
	 * @return the teamWicket
	 */
	public String getTeamWicket() {
		if(teamWicket==null){
			teamWicket = "";
		}
		return teamWicket;
	}
	/**
	 * @param teamWicket the teamWicket to set
	 */
	public void setTeamWicket(String teamWicket) {
		this.teamWicket = teamWicket;
	}
	/**
	 * @return the teamOver
	 */
	public String getTeamOver() {
		if(teamOver==null){
			teamOver = "";
		}
		return teamOver;
	}
	/**
	 * @param teamOver the teamOver to set
	 */
	public void setTeamOver(String teamOver) {
		this.teamOver = teamOver;
	}
	/**
	 * @return the `
	 */
	public String getTeamRate() {
		if(teamRate==null){
			teamRate = "";
		}
		if (teamRate.equalsIgnoreCase("NaN")){
			teamRate = "";
		}
		return teamRate;
	}
	/**
	 * @param teamRate the teamRate to set
	 */
	public void setTeamRate(String teamRate) {
		this.teamRate = teamRate;
	}
	/**
	 * @return the teamExtra
	 */
	public String getTeamExtra() {
		if(teamExtra==null){
			teamExtra = "";
		}
		return teamExtra;
	}
	/**
	 * @param teamExtra the teamExtra to set
	 */
	public void setTeamExtra(String teamExtra) {
		this.teamExtra = teamExtra;
	}
	/**
	 * @return the teamWide
	 */
	public String getTeamWide() {
		if(teamWide==null){
			teamWide = "";
		}
		return teamWide;
	}
	/**
	 * @param teamWide the teamWide to set
	 */
	public void setTeamWide(String teamWide) {
		this.teamWide = teamWide;
	}
	/**
	 * @return the teamNo
	 */
	public String getTeamNo() {
		if(teamNo==null){
			teamLegBye = "";
		}
		return teamNo;
	}
	/**
	 * @param teamNo the teamNo to set
	 */
	public void setTeamNo(String teamNo) {
		this.teamNo = teamNo;
	}
	/**
	 * @return the teamLegBye
	 */
	public String getTeamLegBye() {
		if(teamLegBye==null){
			teamLegBye = "";
		}
		return teamLegBye;
	}
	/**
	 * @param teamLegBye the teamLegBye to set
	 */
	public void setTeamLegBye(String teamLegBye) {
		this.teamLegBye = teamLegBye;
	}
	/**
	 * @return the teamBye
	 */
	public String getTeamBye() {
		if(teamBye==null){
			teamBye = "";
		}
		return teamBye;
	}
	/**
	 * @param teamBye the teamBye to set
	 */
	public void setTeamBye(String teamBye) {
		this.teamBye = teamBye;
	}
	
	
	
	
	
	
}
