%%% ------------------------------------------------------------------
%%% Author  : Chuan Su
%%% Description :
%%%
%%% Created : 2011-12-12
%%% -------------------------------------------------------------------
-module(peer_state_sup).

-behaviour(supervisor).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% External exports
%% --------------------------------------------------------------------
-export([start_link/0]).

%% --------------------------------------------------------------------
%% Internal exports
%% --------------------------------------------------------------------
-export([
	 init/1
        ]).

%% --------------------------------------------------------------------
%% Macros
%% --------------------------------------------------------------------
-define(MAX_RESTART,5).
-define(MAX_TIME,60).
-define(SHUT_DOWN,5000).


%% --------------------------------------------------------------------
%% Records
%% --------------------------------------------------------------------

%% ====================================================================
%% External functions
%% ====================================================================

start_link()->
	supervisor:start_link({local,?MODULE}, ?MODULE, []).


%% ====================================================================
%% Server functions
%% ====================================================================
%% --------------------------------------------------------------------
%% Func: init/1
%% Returns: {ok,  {SupFlags,  [ChildSpec]}} |
%%          ignore                          |
%%          {error, Reason}
%% --------------------------------------------------------------------
init([]) ->
     SupFlags ={one_for_one,?MAX_RESTART,?MAX_TIME},
	 
	 Child_Spec ={peer_state,
				 {peer_state,start_link,[]},
				  permanent,
				  ?SHUT_DOWN,
				  worker,
				 [peer_state,bitfield]},
	  {ok,{SupFlags,[Child_Spec]}}.

%% ====================================================================
%% Internal functions
%% ====================================================================
