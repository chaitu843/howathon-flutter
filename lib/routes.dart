class Routes {
  static const REGISTER_PAGE = '/register-page';
  
  static const HR_LANDING_PAGE = '/hr/landing-page';
  static const HR_SCHEDULE_INTERVIEW_PAGE = '/hr/schedule-interview-page';
  static const HR_ADD_CANDIDATE_PAGE = '/hr/add-candidate-page';

  static const STAFFING_LANDING_PAGE = '/staffing/staffing-landing-page';
  
  static const INTERVIEWER_LANDING_PAGE = '/interviewer/interviewer-landing-page';

  static const ACCOUNT_PAGE = '/account-page';
  static const AUTH_PAGE = '/';
}

class URLs {
  static const GET_CANDIDATES_URL = 'http://18.217.25.220:3000/hr/getAvailaibleCandidates';
  static const POST_CANDIDATES_URL = 'http://18.217.25.220:3000/hr/addCandidate';
  static const LOGIN_URL = 'http://18.217.25.220:3000/home/login';
  static const GET_REQUIREMENTS_URL = 'http://18.217.25.220:3000/staffing/getAccountMapping';
  
  static const GET_REQUIRED_INTERVIEWS_URL = 'http://18.217.25.220:3000/forecast/getForecast';
  static const GET_CANDIDATES_FOR_INTERVIEWER_URL = 'http://18.217.25.220:3000/interviewer/getAllScheduledCandidates';
  static const POST_STATUS_FOR_CANDIDATE_URL = 'http://18.217.25.220:3000/hr/addCandidate';
}