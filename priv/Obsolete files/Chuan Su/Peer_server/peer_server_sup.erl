%%% -------------------------------------------------------------------
%%% Author  : chuan su
%%% Description :
%%%
%%% Created : 2011-11-3
%%% -------------------------------------------------------------------
-module(peer_server_sup).

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
%% --------------------------------------------------------------------
%% Records
%% --------------------------------------------------------------------

%% ====================================================================
%% External functions
%% ====================================================================

start_link()->
	
	supervisor:start_link({local,peer_server_sup}, ?MODULE, []).

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
	
	Sup_Flags= {one_for_one,?MAX_RESTART,?MAX_TIME},
	
	%% supervisor for tcp listener
	
	Child_Spec= {peer_server,                                    %% Internel ID
				{peer_server, start_link,[]}, %% Start Function {M,F,A}
				 permanent,                                      %% Restart =permanent|transient|temporary
				 2000,                                           %% Shutdown =brutal_kill|int()>0|infinity
				 worker,                                         %% Type = worker|supervisor
				 [peer_server,ip]},                                 %% Modules = [Modules]|dynamic

  
    {ok,{Sup_Flags,[Child_Spec]}}.

%% ====================================================================
%% Internal functions
%% ====================================================================

