using ABM4OSN

batch = []
for ac in 50:50:200
    push!(batch,Dict(
        :config=>Config(network=cfg_net(agent_count=ac)),
        :description=>("agent_count_$ac")
        ))
end

for m0 in 2:2:20
    push!(batch,Dict(
        :config=>Config(network=cfg_net(m0=m0)),
        :description=>("m0_$m0")
        ))
end

for gr in 2:2:20
    push!(batch,Dict(
        :config=>Config(network=cfg_net(growth_rate=gr)),
        :description=>("growth_rate_$gr")
        ))
end

for nf in 1:1:10
    push!(batch,Dict(
        :config=>Config(network=cfg_net(new_follows=nf)),
        :description=>("new_follows_$nf")
        ))
end

for i in 1:length(batch)
    batch[i][:result] = simulate(batch[i][:config])
end

batch_sim = []

for n in 50:50:500
    push!(batch_sim, Dict(
        :config=>Config(simulation=cfg_sim(n_iter=n)),
        :description=>"n_iter_$n"
    ))
end



for n in 1:1:10
    push!(batch_sim, Dict(
        :config=>Config(simulation=cfg_sim(max_inactive_ticks=n)),
        :description=>"max_inactive_ticks_$n"
    ))
end

for i in 1:length(batch_sim)
    batch_sim[i][:result] = simulate(batch_sim[i][:config])
end

batch
