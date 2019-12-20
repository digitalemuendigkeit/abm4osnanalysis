using ABM4OSN
using JLD
using JLD2

load("./tmp/xmasbatchtest3_run4_tmpstate.jld2")

configbatch = Config[]

for backfire in [0.2,0.4,0.6], follow in [0.2,0.4], unfollow in [0.4,0.6]
    push!(configbatch, Config(
        network = cfg_net(
            agent_count = 10000,
            m0 = 50,
            growth_rate = 50,
            new_follows = 10
        ), simulation = cfg_sim(
            n_iter = 100,
            max_inactive_ticks = 2
        ), opinion_threshs = cfg_ot(
            like = 0.1,
            share = 0.1,
            backfire = backfire,
            check_unease = 0.3,
            follow = follow,
            unfollow = unfollow
        ), agent_props = cfg_ag(
            own_opinion_weight = 0.95,
            check_decrease = 0.9,
            inclin_interact_lambda = log(25),
            unfollow_rate = 0.05,
            min_input_count = 15,
            mean_desired_input_count = 100
        ), feed_props = cfg_feed(
            feed_size = 10,
            post_decay = 0.5
        )
    ))
end

configbatch[12]

simulate(configbatch, batch_desc = "xmasbatch")

convert_results()


[agent.opinion for agent in test["xmasbatchtest_run1"][3][2] if !agent.active]
