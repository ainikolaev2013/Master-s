load('E:\Grad School\Master''s\CanonVideos\Maria\3780_cut3_stabforehead_stack.mat')
Gdown_stack=stack_blur(Stack);
Stack_forehead=squeeze(Gdown_stack(:,26,26,:));
clear('Stack');
load('E:\Grad School\Master''s\CanonVideos\Maria\3780_cut3_stableftcheek_stack.mat')
Gdown_stack=stack_blur(Stack);
Stack_leftcheek=squeeze(Gdown_stack(:,26,26,:));
clear('Stack');
load('E:\Grad School\Master''s\CanonVideos\Maria\3780_cut3_stabrightcheek_stack.mat')
Gdown_stack=stack_blur(Stack);
Stack_rightcheek=squeeze(Gdown_stack(:,26,26,:));


save('E:\Grad School\Master''s\ain_results-20140220\3780_cut3_stab_Stacks.mat', 'Stack_forehead', 'Stack_leftcheek', 'Stack_rightcheek'); 