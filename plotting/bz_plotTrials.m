function [] = bz_plotTrials(behavior)



f = factor(length(unique(behavior.events.trialConditions)));

for tt = 1:length(unique(behavior.events.trialConditions))
<<<<<<< HEAD
    subplot(length(unique(behavior.events.trialConditions))./f(1),f(1),tt)
=======
    subplot(f(1),length(unique(behavior.events.trialConditions))./f(1),tt)
>>>>>>> master
    ff = find(behavior.events.trialConditions==tt);
    
    for t = 1:length(ff)
    scatter(behavior.events.trials{ff(t)}.x,behavior.events.trials{ff(t)}.y,'.k')
    hold on
    scatter(behavior.events.trials{ff(t)}.x(1),behavior.events.trials{ff(t)}.y(1),'.g')
    scatter(behavior.events.trials{ff(t)}.x(end),behavior.events.trials{ff(t)}.y(end),'.r')
<<<<<<< HEAD

    end
title(tt);
=======
    hold on
    end
%     axis square
title(['condition: ' num2str(tt) ', # of trials: ' num2str(length(ff))]);
>>>>>>> master
end

